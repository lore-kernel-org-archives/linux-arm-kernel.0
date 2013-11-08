From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 8 Nov 2013 15:13:00 +0800
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <CAFRkauDGiy3yZOwKFWMEJvYUe0OoXMEZHKaxogZHdgzMxexdHA@mail.gmail.com>
References: <1383789208.5970.1.camel@phoenix>
 <CACVXFVMn6RSXchQ8u47F35_J+YSnp1bwF1tr-8uCEYwvFsOfgQ@mail.gmail.com>
 <CAFRkauAEt-YhBt11opj_GVCLrxGsTSd2LowWGmukTSmGuJkd3A@mail.gmail.com>
 <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
 <CAFRkauAdR3=ByE0_B3OsqOBjmbz2a02EXb+6g-vn=1TJ7AZc8Q@mail.gmail.com>
 <CACVXFVMaLOfDvzdn_1NryQY59cgtLdMMqHL-_ZAa95MPz4p56Q@mail.gmail.com>
 <CAFRkauDe7V3N0AbfvE_=GEXHZ_Fw62VsA8p50wSUYE1-TRqMfw@mail.gmail.com>
 <87zjpf4w0j.fsf@rustcorp.com.au>
 <CACVXFVNHryPXy2NQhPwXkoCeLUXQSgrWmgBkMNtGD_=X_62_5Q@mail.gmail.com>
 <CAFRkauDGiy3yZOwKFWMEJvYUe0OoXMEZHKaxogZHdgzMxexdHA@mail.gmail.com>
Message-ID: <CACVXFVMAnewCkSNNke3kf1-yO+JCc_HBRp8iaLBPJ+14G79Haw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Fri, Nov 8, 2013 at 12:20 PM, Axel Lin <axel.lin@ingics.com> wrote:
>
>
> Hi Ming,
>
> I have patches on top of 3.12 to support gpl32700 SoC.
> So you cannot find this platform on mainline kernel.

OK, I see.

> I havn't tried perf, below is my config for your reference:
> (to make the config smaller, I grep out disabled config entries.)

I doubt CONFIG_VMSPLIT_3G/CONFIG_PAGE_OFFSET isn't
used at all in your unmerged patchset, also your link script should
be different with in-tree arch/arm/kernel/vmlinux.lds.S, otherwise
you may put all your kernel symbols after 0xC00000000.

Maybe you need to not define PAGE_OFFSET and let it be
PHYS_OFFSET at default, also VMSPLIT_3G shouldn't have
been there on non-MMU linux.


Thanks,
-- 
Ming Lei
