From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 16 Apr 2012 09:19:19 -0600
Subject: [PATCH V4 1/5] of: Implement managed of_iomap()
In-Reply-To: <CAOh2x=n0NfovyfCpcdoMo2a7yLtb=imm1U+R-1L-2ihZ52FUhw@mail.gmail.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
 <201204161442.38725.arnd@arndb.de>
 <CACxGe6tec7y-9VNb9vNiPZhN6bt5MuMV0J18P_7Gk_pDwk-V=Q@mail.gmail.com>
 <CAOh2x=n0NfovyfCpcdoMo2a7yLtb=imm1U+R-1L-2ihZ52FUhw@mail.gmail.com>
Message-ID: <CACxGe6tZhdvoJ60N8g5-P4UHWxB=699_bA2omEQa77u1hEEPrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 9:12 AM, viresh kumar <viresh.linux@gmail.com> wrote:
>
> On Apr 16, 2012 8:37 PM, "Grant Likely" <grant.likely@secretlab.ca> wrote:
>>
>> Why is this function needed? ?I'm directing drivers away from using
>> of_iomap now since the resource table is populated with the address
>> ranges at device registration time now. ?New code should be using
>> platform_get_resource() if it is a platform device.
>>
>
> I thought we must call of_iomap for
> DT only drivers.
> Isn't that the case?

It isn't recommended anymore. Use the bus_type specific helpers instead.

g.
