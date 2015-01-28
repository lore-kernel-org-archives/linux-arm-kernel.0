From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 13:46:27 +0100
Subject: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
 <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
Message-ID: <2323575.nqxsEzcHbG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
> 
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
> In the next version Also I will remove the IOMMU hacks from arasan
> driver

Hmm, I guess you have a required ordering between the patches either
way, which makes it hard to merge in a way that is bisectable.

You are correct that you should not merge a patch with the iommu
reference before adding the iommu device node, because it would
otherwise break building the mmc tree.

Usually, the right answer is to merged the dts changes through the
arm-soc tree, and then you can just add the node for the sdhc device
after the one for the iommu device.

	Arnd
