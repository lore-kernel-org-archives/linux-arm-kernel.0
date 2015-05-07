From: j.fanguede@virtualopensystems.com (=?UTF-8?B?SsOpcsOpbXkgRmFuZ3XDqGRl?=)
Date: Thu, 7 May 2015 12:50:50 +0200
Subject: [RFC] ARM/ARM64: KVM: Implement KVM_FLUSH_DCACHE_GPA ioctl
In-Reply-To: <20150506141249.GA6796@cbox>
References: <1430817191-6231-1-git-send-email-j.fanguede@virtualopensystems.com>
 <20150506141249.GA6796@cbox>
Message-ID: <CAGE1QJrabWWs0O1V-MpOxT_=1472TXb5rvJzJAJNfWH70x9pcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 4:12 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Hi J?r?my,
>
> On Tue, May 05, 2015 at 11:13:11AM +0200, J?r?my Fangu?de wrote:
>> To maintain cache coherency on ARM, we may need a mechanism to flush
>> the data cache.
>
> In addition to generally just making this functionality available (see
> below), do you have an actual use case in mind for this?  To solve the
> VGA issue, for example, we already have a patch series from Drew trying
> to address this.  Does that not work for you?
>
> There was a long discussion about this here:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-February/013593.html
>
> Drew then created a patch set, here:
> https://lists.nongnu.org/archive/html/qemu-devel/2015-03/msg01254.html
>
> and replied to himself, here:
> https://www.marc.info/?l=android-virt&m=142670523929132&w=3
>
> Which basically says that he doesn't like having to do flushes all over
> QEMU (IIUC), so he sent this version instead:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-March/014027.html
>
> Which he now said he'd respin.

In fact, I used this ioctl in pairs with this QEMU patch series:
https://lists.nongnu.org/archive/html/qemu-devel/2015-05/msg00407.html
My current work doesn't do anything about vga ram, so vga issue
probably still persists, but it solves others issues with some
emulated devices (mainly PCI) which were failing before and now work
fine with this patch.
