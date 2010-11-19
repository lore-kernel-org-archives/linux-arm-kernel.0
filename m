From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Fri, 19 Nov 2010 07:57:58 -0600
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	<AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	<20101119125353.GB5818@legolas.emea.dhcp.ti.com>
Message-ID: <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Fri, Nov 19, 2010 at 6:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi Hari,
>
> On Fri, Nov 19, 2010 at 06:29:39AM -0600, Kanigeri, Hari wrote:
>>
>> How do you know that a response is received for a particular sender ?
>
> think of it as FIFO. So the first completed message is the first in your
> list of requests. Ain't that easy ? :-)

Actually it isn't that easy ;) because there is no guarantee that the
completed message is the first one in the list of requests.
Responses could be asynchronous and we cannot depend on serialized
handling of requests on BIOS...even in some cases you might not even
get a response for particular request in which case you have to handle
that in IPC module.

eg: Process A sends a message to M3 core to kick off some translation
in some codec, the thread handling this request running on BIOS would
kick off the translation and wait for the completion before sending
the response. In the mean time BIOS will be handling other requests
coming to it, and shouldn't be blocked until the completion of first
request.


>
> Still it doesn't the fact that currently you allow for that. There are
> malware writers everywhere. But hey, it would be cool to have mailbox
> appear on securityfocus.com :-p
>

Agree about malware writers. Add PM interfaces as well to the list as
one can misuse them as well ;)


Thank you,
Best regards,
Hari Kanigeri
