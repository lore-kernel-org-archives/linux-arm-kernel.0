From: pwaechtler@mac.com (Peter =?iso-8859-1?q?W=E4chtler?=)
Date: Wed, 13 Apr 2011 20:19:16 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <BANLkTintPVJoJCyRJCX9f2j8KD5BPgrXrA@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTintPVJoJCyRJCX9f2j8KD5BPgrXrA@mail.gmail.com>
Message-ID: <201104132019.16294.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. April 2011, 21:11:59 schrieb Colin Cross:
> On Tue, Apr 12, 2011 at 11:52 AM, Peter W?chtler <pwaechtler@mac.com> wrote:
> > Hello Linux ARM developers,
> > 
> > did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> > Or was the memory always mapped in sections?
> > 
> > I still have to chase a potential memory corruption. The rootfs is
> > located on a SDcard and gets corrupted even when the filesystem test
> > programs write to different partitions.
> > The test scenario includes several dozen or even hundreds of warm and
> > cold boot sequences, file system write tests with sudden soft resets.
> > It's a large embedded project with a lot of drivers and the fact that
> > always the rootfs and often the superblock gets damaged let me think of
> > a memory corruption.
> 
> Gary King posted some patches a while ago that switched the kernel
> back to page mappings, so he could modify attributes on some pages to
> be non-cacheable.  The patches were not accepted, but you can probably
> dig them up for testing.

Thanx for the tip. I already found the patch and applied it. Some probs on 
config but not tested yet...

   Peter
