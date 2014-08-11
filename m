From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Mon, 11 Aug 2014 13:32:57 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <20140808180900.GG30282@n2100.arm.linux.org.uk>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell and Fabio,

> I'd be interested to hear whether removing the
> 
> 	interrupts-extended = ...
> 
> property from your board's DT file, thereby causing you to revert back to the
> default I list above, also fixes the instability you are seeing.

We have tried to remove the board specific interrupts-extended field and the
MX6QDL_PAD_GPIO_6__ENET_IRQ entry. Sadly this did not seem to improve
the stalls. Our interrupts look like this now:

150:      15519          0          0          0       GIC 150  2188000.ethernet
151:          0          0          0          0       GIC 151  2188000.ethernet

Our device tree might still be slightly incorrect. We have noticed that our
RGMII_INT is connected to GPIO 19 (P5) which might be nonstandard (we are
a bit surprised that this works at all). We are not quite sure how to configure
this properly.

Best regards,
Mattis Lorentzon
***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
