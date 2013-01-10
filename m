From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 10 Jan 2013 17:42:58 +0900
Subject: [PATCH 1/8] SH: intc: Add support OF for INTC
In-Reply-To: <20130109115352.GB7337@e106331-lin.cambridge.arm.com>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
 <1357713007-4005-2-git-send-email-horms+renesas@verge.net.au>
 <20130109115352.GB7337@e106331-lin.cambridge.arm.com>
Message-ID: <CANqRtoSvUdEbs-vkJZtAvVY5ypiBWeZwhPr39_nZpJj7MOtk0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jan 9, 2013 at 8:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> Thanks for updating the text, this is far easier to read than previously.
>
> However, I'm still concerned by how complex the binding seems. As I don't have
> any familiarity with the device, I don't know whether that's just an artifact
> of the hardware or something that can be cleared up.

Iwamatsu-san wrote this binding based on our C version of the INTC
tables. And I wrote the original INTC table code based on perhaps 30+
data sheet. They code was initially designed to allow people to input
data straight off the data sheet - this so we could support a wide
range of slightly different interrupt controllers.

> I think the approach used by the binding needs some serious review before this
> should be merged. It seems far more complex than any existing interrupt
> controller binding. Without a dts example for a complete board (complete with
> devices wired up to the interrupt controller), it's difficult to judge how this
> will work in practice.

Feel free to review the code, but I am not sure why anyone would case
about this Renesas specific legacy interrupt controller. If I were to
chose how cycles should be spent then I think it is better to try to
come up with power domain DT bindings for all SoC vendors.

Also, there are the DT board code queued up that makes use of this controller.

Thanks,

/ magnus
