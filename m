From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 18 Jul 2013 17:15:21 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabled
In-Reply-To: <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
Message-ID: <CAPnVf8yH7PBOSSC57qJv+pWmsinRUxGr81QUPH9GoOkKw2oo3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2013 14:25, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Mon, 15 Jul 2013, Julien Grall wrote:
>> Even if uncompress debug is disabled, some board will continue to print
>> information during uncompress step.
>
> Are you talking about DEBUG_UNCOMPRESS?
> Should I read the sentence as "even if DEBUG_UNCOMPRESS is not selected,
> some board will continue to print information during the uncompress step"?

Yes. On the arndale, uncompress log are directly output on UART-2.
This is annoying
because  Xen doesn't expose the UART to dom0.

> Isn't this a bug in the platform specific code that should be fixed anyway?
>
>> By using debug/uncompress.h include, all debug output will be disabled.
>
> I am not sure if this is the right solution to the problem.
> I think it might be better to add the appropriate ifdefs into the
> platform specific code.

--
Julien Grall
