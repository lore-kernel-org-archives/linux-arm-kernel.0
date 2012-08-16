From: rm@romanrm.ru (Roman Mamedov)
Date: Thu, 16 Aug 2012 23:25:49 +0600
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <20120816150647.GA22010@sig21.net>
References: <50299142.2030504@oberhumer.com> <20120814123937.GA14756@sig21.net>
 <502B8FE3.7080501@oberhumer.com> <20120815144539.GA8300@sig21.net>
 <502C92C3.7090701@oberhumer.com> <20120816150647.GA22010@sig21.net>
Message-ID: <20120816232549.4d14a6aa@natsu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Aug 2012 17:06:47 +0200
Johannes Stezenbach <js@sig21.net> wrote:

> Well, ~2x speedup on x86 is certainly a good achievement, but there
> are more ARM based devices than there are PCs, and I guess many
> embedded devices use lzo compressed kernels and file systems
> while I'm not convinced many PCs rely on lzo in the kernel.

Keep in mind that a major user of LZO is the BTRFS filesystem, and I believe it
is used much more often on larger machines than on ARM, in fact it had problems
operating on ARM at all, until quite recently.

> I know everyone's either busy or on vacation, but it would
> be so cool if someone could test on a more modern ARM core,
> with the userspace test code I posted it should be easy to do.

I have locked the Allwinner A10 CPU in my Mele A2000 to 60 MHz using cpufreq-set,
and ran your test. rnd.lzo is a 9 MB file from /dev/urandom compressed with lzo.
There doesn't seem to be a significant difference between all three variants.

# time for i in {1..20}; do old/unlzop < rnd.lzo >/dev/null ; done

real	0m11.353s
user	0m3.060s
sys	0m8.170s
# time for i in {1..20}; do new/unlzop < rnd.lzo >/dev/null ; done

real	0m11.416s
user	0m3.030s
sys	0m8.200s
# time for i in {1..20}; do test/unlzop < rnd.lzo >/dev/null ; done

real	0m11.310s
user	0m3.100s
sys	0m8.150s

-- 
With respect,
Roman

~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Stallman had a printer,
with code he could not see.
So he began to tinker,
and set the software free."
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120816/d1a5e749/attachment.sig>
