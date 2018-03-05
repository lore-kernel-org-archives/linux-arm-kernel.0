From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 5 Mar 2018 08:22:52 +0100
Subject: [RFC][PATCH] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <CAMuHMdU=S2RbnzkGcyHd9iNke4tiY8D8P9XnFdSoJD5TN3oOaA@mail.gmail.com>
References: <20180226101718.5353-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdU=S2RbnzkGcyHd9iNke4tiY8D8P9XnFdSoJD5TN3oOaA@mail.gmail.com>
Message-ID: <7eab13e5-f305-4db2-3ea1-04abb489e134@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 09:43 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Feb 26, 2018 at 11:17 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Rather than hard-coding the quirk topology, which stopped scaling,
>> parse the information from DT. The code looks for all compatible
>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
>> to the same pin. If so, the code sends a matching sequence to the
>> PMIC to deassert the IRQ.
> 
> Note that not all R-Car Gen2 boards have all regulators described in DT yet.
> E.g. gose lacks da9210. So that has to be fixed first.

Argh, yes.

-- 
Best regards,
Marek Vasut
