From: ludovic.barre@st.com (Ludovic BARRE)
Date: Tue, 19 Dec 2017 09:45:50 +0100
Subject: [PATCH V2 9/9] ARM: dts: stm32: add initial support of
 stm32mp157c eval board
In-Reply-To: <CAK8P3a14KzxGK8j75UUBfWgexg2fdzrtdgcqUT=uHfjWrVaWbA@mail.gmail.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-10-git-send-email-ludovic.Barre@st.com>
 <CAK8P3a14KzxGK8j75UUBfWgexg2fdzrtdgcqUT=uHfjWrVaWbA@mail.gmail.com>
Message-ID: <769a6837-2e52-418c-34d9-47abee216029@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/18/2017 09:20 PM, Arnd Bergmann wrote:
> On Mon, Dec 18, 2017 at 4:17 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:
> =
>> +
>> +/ {
>> +       model = "STMicroelectronics STM32MP157C eval daughter";
>> +       compatible = "st,stm32mp157c-ed1", "st,stm32mp157";
>> +
>> +       chosen {
>> +               bootargs = "earlyprintk console=ttySTM3,115200 root=/dev/ram";
>> +               stdout-path = "serial3:115200n8";
>> +       };
> 
> I'd remove the bootargs here and let the boot loader take care of
> that, in particular
> since all three arguments are rather old-school: earlycon is preferred over
> earlyprintk, console= should not be needed if you set stdout-path, and
> /dev/ram is obsoleted by initramfs.
OK, thanks

BR
Ludo

> 
>          Arnd
> 
