From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 09:07:47 +0530
Subject: [PATCH V3 4/4] SPEAr3xx: Add pinctrl support for boards
In-Reply-To: <4F8851E5.7050509@wwwdotorg.org>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <81b04bd4fe751633802e539d724facce80e600a4.1334207964.git.viresh.kumar@st.com>
 <4F8851E5.7050509@wwwdotorg.org>
Message-ID: <4F8B940B.7030700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 9:48 PM, Stephen Warren wrote:
> On 04/11/2012 11:24 PM, Viresh Kumar wrote:
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> Just a couple of minor comments below.

No Probs.

>> diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
> 
>> +		pinmux at 99000000 {
>> +			st,pinmux-mode=<2>;
> 
> spaces around = here for consistency?

Ok.

>> +			state_default: pinmux {
>> +				i2c0 {
>> +					st,pins = "i2c0_grp";
>> +					st,function = "i2c0";
>> +				};
> 
> Do the group names need the "_grp" suffix? If that's what's in your TRM,
> it's fine by me, but I'd guess that isn't the case, and if so I'd say
> either drop the _grp suffix here, or enhance the binding documentation
> to mention the need to add this suffix when writing the .dts file.

Updated Documentation clearly for this.

As you have spent a lot of time getting these reviewed, i would add your
Reviewed-by on all these patches. Hope that would be fine?

Will fix all these, resend them and send a pull request to Arnd.

-- 
viresh
