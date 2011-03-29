From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Tue, 29 Mar 2011 19:48:05 +0530
Subject: [OpenWrt-Devel] linker errors like ignoring invalid character `#'
	in expression
In-Reply-To: <AANLkTima8pjzo4y89MH6ntdJEqqq72gToCXjskSXCO9p@mail.gmail.com>
References: <AANLkTim6qKQ78J+L28iCDhretGY+g_6zo3TznAWL=-LC@mail.gmail.com>
	<AANLkTikDfakPT3LxqEuaAcz3o3hH=Mub-oaCma_-szia@mail.gmail.com>
	<AANLkTima8pjzo4y89MH6ntdJEqqq72gToCXjskSXCO9p@mail.gmail.com>
Message-ID: <AANLkTim_4V7o0p7ijmfmHUxS22WgUkXd+h-AXPzRDacN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 7:38 PM, Jonathan Bennett <jbscience87@gmail.com> wrote:
> On Tue, Mar 29, 2011 at 9:06 AM, Madhavi Manchala
> <madhavi.linux@gmail.com> wrote:
>> On Tue, Mar 29, 2011 at 7:16 PM, Madhavi Manchala
>> <madhavi.linux@gmail.com> wrote:
>>> Dear All,
>>>
>>> I am seeing the following linker error messages when I try to build
>>> the OpenWRT image for my board.
>>>
>>> arm-openwrt-linux-uclibcgnueabi-ld:arch/arm/kernel/vmlinux.lds:284:
>>> ignoring invalid character `#' in expression
>>> arm-openwrt-linux-uclibcgnueabi-ld:arch/arm/kernel/vmlinux.lds:284: syntax error
>>>
>>> I googled, but there is no much luck for me. I did not understand why
>>> am I getting this error.
>>>
>>> Any suggestions / hints would be appreciated.
>>>
>>> Thanks for your help, too.
>>>
>>> Thanks and Regards,
>>> Madhavi M.
>>
>> Dear All,
>>
>> It was resolved. Thanks.
>
> That's great! However, a few words of explanation might be helpful in
> case anyone else runs across this issue. (And I'm curious.)

Dear Jonathan Bennett,

It was due to a comment line which is placed in the
arch/arm/kernel/vmlinux.lds file. The comment was added as //comment.
However, when I looked whole vmlinux.lds file, all the comments are
included in /* */. So, I changed it to /* */ instead //. Then it
compiled. I do not know the exact reason for that. May be .lds files
do not accept the comments in //.

Thanks.

Regards,
Madhavi M.

>>
>> Regards,
>> Madhavi M.
>
> ~Jonathan Bennett
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel at lists.openwrt.org
> https://lists.openwrt.org/mailman/listinfo/openwrt-devel
>
