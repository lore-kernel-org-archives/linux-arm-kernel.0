From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 26 Jul 2017 17:45:15 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170726153502.GE28875@nazgul.tnic>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
 <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com>
 <20170726131058.GA8665@hc>
 <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
 <20170726145522.GC28875@nazgul.tnic> <20170726151314.GA10696@hc>
 <20170726153502.GE28875@nazgul.tnic>
Message-ID: <20170726154515.GA11453@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 05:35:02PM +0200, Borislav Petkov wrote:
> On Wed, Jul 26, 2017 at 05:13:14PM +0200, Jan Glauber wrote:
> > I'm also looking for CPU implementor (MIDR), I could check for the model
> > too but I still need to detect devices based on PCI IDs as the model
> > check is not sufficient here (only multi-socket ThunderX has OCX TLK
> > devices).
> 
> So what does that mean? The only way to load a PMU driver and an EDAC
> driver is the PCI ID of the memory controller? No other way?

I already tried multiple ways to load the drivers, so far with limited
success :)

The PMU/EDAC devices are all PCI devices do I need the 'struct pci_dev *'.
I'm not aware of other ways to access these devices. Please enlighten
me if I'm missing something.

--Jan
