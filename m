From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 19 Feb 2011 23:00:37 +0530
Subject: [PATCH V5 57/63] ST SPEAr3xx: Updating plgpio and emi source to
	make it compliant with single image strategy
In-Reply-To: <20110219165042.GN29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<29f3e319e062a9f2f65ea9683fb9663f938dfa3b.1295499395.git.viresh.kumar@st.com>
	<20110219165042.GN29493@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=zwKCJjwiB-obib_KYqAmgJ5AGm8cAuhAvrP=D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2011 at 12:56:35PM +0530, Viresh Kumar wrote:
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>
> Why aren't the plgpio bits of this in patch 16?
>

Because we made these changes after that single image solution. And
yes we should
have done our homework on this cleanly and merged all this in patch 16
and emi's patch.

>> +static u32 plgpio_enb, plgpio_wdata, plgpio_dir, plgpio_rdata, plgpio_ie,
>> +	   plgpio_mis;
>
> 'int' or 'unsigned int' will do for these.  There's no pressing need for
> these to be exactly 32-bit quantities.
>

Yes.

>>  static int __init plgpio_init(void)
>>  {
>> +	if (machine_is_spear310()) {
>> +		plgpio_enb = SPEAR310_PLGPIO_ENB;
>> +		plgpio_wdata = SPEAR310_PLGPIO_WDATA;
>> +		plgpio_dir = SPEAR310_PLGPIO_DIR;
>> +		plgpio_rdata = SPEAR310_PLGPIO_IE;
>> +		plgpio_ie = SPEAR310_PLGPIO_RDATA;
>> +		plgpio_mis = SPEAR310_PLGPIO_MIS;
>> +	} else if (machine_is_spear320()) {
>> +		plgpio_enb = SPEAR320_PLGPIO_ENB;
>> +		plgpio_wdata = SPEAR320_PLGPIO_WDATA;
>> +		plgpio_dir = SPEAR320_PLGPIO_DIR;
>> +		plgpio_rdata = SPEAR320_PLGPIO_IE;
>> +		plgpio_ie = SPEAR320_PLGPIO_RDATA;
>> +		plgpio_mis = SPEAR320_PLGPIO_MIS;
>> +	} else {
>> +		return 0;
>
> If it's not supported, then what about returning an error instead of
> zero?
>

Yes. Error must be returned.

> Can you supersede this patch and patch 16 in the patch system with a
> single patch which adds PLGPIO support with no further updates.
>
> You may also consider combining the EMI updates with the patch which
> creates EMI support in the first place, which I think is patch 36.
>

Will do this for both plgpio and emi.
