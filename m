From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 12 Mar 2010 09:52:57 +0530
Subject: [PATCH 05/11] ST SPEAr: Added clock framework for SPEAr	platform
	and machines
In-Reply-To: <20100311102845.GA16376@n2100.arm.linux.org.uk>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-6-git-send-email-viresh.kumar@st.com>
	<20100311102845.GA16376@n2100.arm.linux.org.uk>
Message-ID: <4B99C1A1.3070402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/11/2010 3:58 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 03, 2010 at 10:37:35AM +0530, Viresh KUMAR wrote:
>> +/* array of all spear 3xx clock lookups */
>> +static struct clk_lookup *spear_clk_lookups[] = {
>> +	/* root clks */
>> +	&osc_32k_cl,
>> +	&osc_24m_cl,
> 
> This is rather wasteful - rather than defining structures, and then having
> a one-time-used set of pointers to the structures, why not just declare
> the whole lot as an array like most other implementations do?
> 

I did it to make it more readable. But, obviously it is wasting some amount
of memory for just nothing. Will change it with an array implementation.

regards,
viresh kumar.
