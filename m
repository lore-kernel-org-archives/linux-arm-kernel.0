From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2012 15:23:17 +0100
Subject: [PATCH v3 3/4] dt: add clock binding doc to primecell bindings
In-Reply-To: <4FE47968.9040105@codethink.co.uk>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <1339512111-11172-4-git-send-email-robherring2@gmail.com>
 <4FE47968.9040105@codethink.co.uk>
Message-ID: <20120622142317.GC30087@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 02:55:52PM +0100, Ben Dooks wrote:
> On 12/06/12 15:41, Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> Add clock binding information for primecell peripherals. For most, a
>> clock input name of "apb_pclk" is required. Any primecell peripherals
>> which are different will need to be documented separately.
>
> Really they should just use NULL as their bus clock name,
> and the drivers be fixed for this.

Ben,

Do you know what you're talking about, because I don't think you do.  You
seem to be making random spontaneous comments without really knowing the
background behind things.

In this case, apb_pclk is the APB PCLK signal, as opposed to any
_functional_ clock required by the primecell peripheral.  To use NULL
there when the primecell probably _also_ takes a functional clock is
absurd, and to go on to suggest that the bus layer should be using NULL
here is insane.

We really do not want the bus layer picking up on the functional clock
"by accident" because someone forgot to give it.  Using a non-NULL name
here is entirely appropriate.

Please take some time to research the things that you're commenting on
before commenting on them, to avoid leading people down inappropriate
paths.

Thank you.
