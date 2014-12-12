From: bgriffis@ti.com (Griffis, Brad)
Date: Fri, 12 Dec 2014 14:16:29 +0000
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de>	<547C3A95.30605@ti.com>
 <547C3C19.5090501@linutronix.de>	<547C42FF.5010700@ti.com>
 <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
 <548A0125.6040708@linutronix.de>
 <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
Message-ID: <912A29987EAE174BA6CF187D7CDFA9CE26FA135A@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Crenguta [mailto:catalin.crenguta at gmail.com]
> I have tried your patches by cloning [1] and copying the relevant files over
> the kernel I've cloned from [2].
> It compiles & runs, but I'm seeing lots of pen-down/pen-up events when I'm
> not touching the screen.
> Any suggestions?

How are you configuring ti,charge-delay in your dts?  I've seen this behavior on some custom boards where we were using a smaller charge delay (0x400) to begin with, and by upping it to 0xb000 we resolved the issue.  These patches however already specified ti,charge-delay = 0xb000 by default so this would surprise me that it's still seeing that issue.  Was the touchscreen working as expected before these new patches, or does it have issues both ways?
