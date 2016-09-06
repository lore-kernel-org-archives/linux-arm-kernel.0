From: jorik@kippendief.biz (Jorik Jonker)
Date: Tue, 6 Sep 2016 10:52:02 +0200
Subject: [PATCH v2 4/7] dts: sun8i-h3: add UART1-3 to Orange Pi Plus
In-Reply-To: <CAGb2v67dnnxOp_yPyC8icu-m0WZ-Rs1STs1tnxJMOLfcRfRzUg@mail.gmail.com>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
 <20160902070425.GB6313@lukather>
 <20160903120932.GA6289@carbon.kippendief.biz>
 <20160905193111.GC4728@lukather>
 <CAGb2v67dnnxOp_yPyC8icu-m0WZ-Rs1STs1tnxJMOLfcRfRzUg@mail.gmail.com>
Message-ID: <20160906085202.GA4854@carbon.kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 11:04:38AM +0800, Chen-Yu Tsai wrote:
>In short, I'm ok with it. But please put an explicit
>
>    status = "disabled";
>
>and probably a comment about how/where the peripheral can be
>used in the board dts.

Allright, I will do that in v3.

>I intended to do this for the Banana Pis. Though my original plan
>was to enable Raspberry Pi compatible peripherals by default, and
>list the other peripherals that are defined by the vendor as
>"disabled".
>
>"Defined by the vendor" means that the vendor has some sort of
>document associating the gpio header pins with the peripherals,
>as shown in:
>
>    http://www.orangepi.org/Docs/Pindefinition.html#CON3_Definition
>
>This should make it easier for the average user to enable the
>peripherals. I'm not sure we should list _all_ possible ones
>though. That would make the list very large, and some might
>end up never being used.

This is exactly what I was thinking, albeit I wanted to go a bit 
'bigger': move all unambiguous pinmux/peripheral associations from the 
H3 DTS files to the DTSI, complete them with known associations for 
which there are drivers, and have all of these disabled. Reduce the 
existing blocks in the DTS files to just "status = okay".

Peripherals requiring board-specific things (like emac, USB, voltage 
regulators, displays) stay put in the DTS.

It will explodes the scope of my proposed change a bit, but if you are 
OK with this, I will gladly do it.

Maxime, Chen-Yu: what do you think of this?

Best,

Jorik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/8b3d5987/attachment.sig>
