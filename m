From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Wed, 28 Jan 2015 18:46:53 +0800
Subject: [PATCH v9 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <20150128095401.GC14175@tarshish>
References: <1422413261-17184-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422413261-17184-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150128061250.GQ2555@sapphire.tkos.co.il>
 <CAAfSe-v4FGpHL3N3utiDwcoc7qus1XZZszuXBqB6LeE1frAfeA@mail.gmail.com>
 <20150128095401.GC14175@tarshish>
Message-ID: <CAAfSe-t-to3=KrUH2cWQXy710H8Lr3Nd7Za1yoaxio4i70c51w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 5:54 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Lyra Zhang,
>
> On Wed, Jan 28, 2015 at 04:46:33PM +0800, Lyra Zhang wrote:
>> On Wed, Jan 28, 2015 at 2:12 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>> > On Wed, Jan 28, 2015 at 10:47:41AM +0800, Chunyan Zhang wrote:
>> >> +             if (uart_handle_sysrq_char(port, ch))
>> >> +                     continue;
>> >
>> > My comment[1] on a previous version of this patch still stands.
>> > uart_handle_sysrq_char is a NOP when SUPPORT_SYSRQ is not defined.
>>
>> yes, there are two definitions in serial_core.h, and it returns 0 when
>> SUPPORT_SYSRQ is not defined.
>> so, I think my code behavior does not hurt, right?
>
> Right. I just wanted to point out that you can easily define SUPPORT_SYSRQ as
> appropriate like many other serial drivers do to get sysrq support.
>

Ok, I got it. I'll add SUPPORT_SYSRQ definition, and send v10 to Greg.

thanks,
Chunyan

> baruch
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
