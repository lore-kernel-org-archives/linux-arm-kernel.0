From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 15:25:18 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129162337.0121cbab@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129161211.7bb8cada@skate>
 <20130129151501.GY23505@n2100.arm.linux.org.uk>
 <20130129162337.0121cbab@skate>
Message-ID: <20130129152518.GZ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 04:23:37PM +0100, Thomas Petazzoni wrote:
> Russell,
> 
> Thanks for your quick feedback!
> 
> On Tue, 29 Jan 2013 15:15:01 +0000, Russell King - ARM Linux wrote:
> 
> > Given the description, I'd feel much happier with this if we specified
> > the alignment numerically rather than allowing "some random code" to do
> > something with the passed values.
> 
> So, you'd prefer to have two new members added in the hw_pci structure
> to give the alignment requirements for I/O regions and memory regions?

Yep, otherwise we'll have yet more code to review rather than one
algorithm with a set of numbers...

I work on the principle that if something can be expressed numerically,
that's always better than expressing it with code.
