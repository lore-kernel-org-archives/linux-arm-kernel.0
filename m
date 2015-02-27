From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 Feb 2015 22:37:10 +0100
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <1424799222-9301-1-git-send-email-lee.jones@linaro.org> (Lee
 Jones's message of "Tue, 24 Feb 2015 17:33:38 +0000")
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
Message-ID: <87385r3uk9.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> v2 => v3:
>   - Ensure DT actually reflects h/w
>     - i.e. Nodes should not contain a mishmash of different IP
>       blocks, but should identify related h/w.  In the current
>       example we use interconnects
>   - Change naming from clkdomain to clk-always-on
>   - Place "do not abuse" warning in documentation
>
> v1 => v2:
>   - Turned the ST specific driver into a generic one
>   
> Hardware can have a bunch of clocks which must not be turned off.
> If drivers a) fail to obtain a reference to any of these or b) give
> up a previously obtained reference during suspend, the common clk
> framework will attempt to turn them off and the hardware will
> subsequently die.  The only way to recover from this failure is to
> restart.
>   
> To avoid either of these two scenarios from catastrophically
> disabling the running system we have implemented a clock domain
> where clocks are consumed and references are taken, thus preventing
> them from being shut down by the framework.

Hi Lee,

I wonder why there is a need for a new clock when CLK_IGNORE_UNUSED does
exist. What is the usecase that is covered by this patchset which is not used by
CLK_IGNORE_UNUSED clock flag ?

And if that reason exists, I'd like to find it in the commit message.

Cheers.

--
Robert
