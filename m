From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 16:23:37 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129151501.GY23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129161211.7bb8cada@skate>
 <20130129151501.GY23505@n2100.arm.linux.org.uk>
Message-ID: <20130129162337.0121cbab@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for your quick feedback!

On Tue, 29 Jan 2013 15:15:01 +0000, Russell King - ARM Linux wrote:

> Given the description, I'd feel much happier with this if we specified
> the alignment numerically rather than allowing "some random code" to do
> something with the passed values.

So, you'd prefer to have two new members added in the hw_pci structure
to give the alignment requirements for I/O regions and memory regions?

Something like:

struct hw_pci {
	[...]
	unsigned long io_align;
	unsigned long mem_align;
};

If that's fine with you, I'll go ahead and change the implementation in
this direction. As long as I can express my special 64 KB alignment
requirement for I/O regions, I'm just fine :-)

Thanks again,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
