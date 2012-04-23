From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Apr 2012 17:26:23 +0100
Subject: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
In-Reply-To: <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
 <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
 <4F9514AA.10403@arm.com>
 <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
 <4F9547E3.4000709@arm.com>
 <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
 <4F9573B8.9050607@arm.com>
 <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com>
 <4F957A0C.7060607@arm.com>
 <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com>
 <4F957F62.5090605@arm.com>
 <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com>
Message-ID: <4F9582AF.6040501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/12 17:16, viresh kumar wrote:
> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Well, it definitely should. Can you share the relevant part of your DT?
> 
> I Just tested it once, and will do it tomorrow again.
> 
> 			wdt at ec800620 {
> 				compatible = "arm,cortex-a9-twd-wdt";
> 				reg = <0xec800620 0x20>;
> 				interrupts = <1 14 0x301>;
> 				status = "disabled";
> 			};
> 
> Looking at your confidence, i am starting to feel, i am wrong here ;)

Well, having written the code that ensures request_irq() fails when
passed a PPI, I'd be very worried if the above started to be working... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
