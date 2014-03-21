From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 21 Mar 2014 14:58:06 +0000
Subject: [PATCH v4] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <CAASgrz0SaoNGb+ss6ZS+Zh_NoBzmznaneRur7xzp4_dyGb-wMg@mail.gmail.com>
References: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>
 <CAASgrz0SaoNGb+ss6ZS+Zh_NoBzmznaneRur7xzp4_dyGb-wMg@mail.gmail.com>
Message-ID: <CAPvkgC1K-_DTo7JreJm2v3Bp8keQY7Kwv6LD5c37-ii9+n5eMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2014 00:49, David Riley <davidriley@chromium.org> wrote:
> Hi Nathan,
>
> I gave this a try against a 3.10 system and ran into issues when
> vdso.so grew to two pages because of of a large .GCC.command.line
> section.  __get_datapage was returning an address that was at the
> beginning of the second code page instead of the data page since it
> didn't account for the additional section.  I got it working by adding
> .GCC.command.line to the DISCARD group in the linker script, but in
> general it feels as if this code is a bit fragile since it depends on
> knowing exactly which sections exist in the .so for the _vdso_data
> symbol to be correct.
>
> Cheers,
> David
>

Hi David,
Could you please send us the following output:
$ nm -C ./arch/arm/kernel/vdso/vdso.so.dbg

For the vdso without the extra DISCARD?
(As I'm interested in the alignment of __vdso_data)

Cheers,
--
Steve
