From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Sep 2009 08:51:22 -0700
Subject: [PATCH 06/12] omap: mailbox: Flush posted write when acking
	mailbox irq
In-Reply-To: <4ABC6D55.3000108@gmail.com>
References: <20090924233027.6065.95725.stgit@localhost>
	<20090924233920.6065.16789.stgit@localhost>
	<4ABC6D55.3000108@gmail.com>
Message-ID: <20090925155121.GU4919@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Artem Bityutskiy <dedekind1@gmail.com> [090925 00:15]:
> On 09/25/2009 02:39 AM, Tony Lindgren wrote:
>> From: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>>
>> The only way to flush posted write to L4 bus is to do a read back
>> of the same register right after the write.
>
> Just curious, is it really necessary to read back the _same_ register?
> Would reading back any L4 bus-related register be sufficient?

It seems that reading back any register in the same device will do it.

Tony
