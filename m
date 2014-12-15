From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Mon, 15 Dec 2014 09:55:56 +0200
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <912A29987EAE174BA6CF187D7CDFA9CE26FA135A@DLEE08.ent.ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547C3A95.30605@ti.com>
 <547C3C19.5090501@linutronix.de> <547C42FF.5010700@ti.com>
 <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
 <548A0125.6040708@linutronix.de>
 <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
 <912A29987EAE174BA6CF187D7CDFA9CE26FA135A@DLEE08.ent.ti.com>
Message-ID: <CABH3fy8PqbC3DZkFLcoaaXqFAex+oCh7=1a=-cymhXU_ayDNcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 4:16 PM, Griffis, Brad <bgriffis@ti.com> wrote:

> How are you configuring ti,charge-delay in your dts?  I've seen this behavior on some custom boards where we were using a smaller charge delay (0x400) to begin with, and by upping it to 0xb000 we resolved the issue.  These patches however already specified ti,charge-delay = 0xb000 by default so this would surprise me that it's still seeing that issue.  Was the touchscreen working as expected before these new patches, or does it have issues both ways?

Initially I had set the charge-delay to 0x400 and I was seeing many
false pen-down/pen-up events With 0xb000, I was still getting many of
them but less than with 0x400.
