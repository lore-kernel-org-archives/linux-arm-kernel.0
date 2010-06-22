From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue, 22 Jun 2010 10:12:29 +0530
Subject: [PATCH v2] GPIO PL061: Adding Clk framework support
In-Reply-To: <AANLkTimtw4_M4V1ZinQfvi8BGarElXjr47PvTpbQJeiy@mail.gmail.com>
References: <1277179650-1440-1-git-send-email-viresh.kumar@st.com>
	<AANLkTimtw4_M4V1ZinQfvi8BGarElXjr47PvTpbQJeiy@mail.gmail.com>
Message-ID: <4C203F35.3060402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/2010 9:51 AM, Rabin Vincent wrote:
> On Tue, Jun 22, 2010 at 9:37 AM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>> +static int pl061_request(struct gpio_chip *gc, unsigned offset)
>> +{
>> +       struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
>> +       int ret;
>> +
>> +       if (offset >= gc->ngpio)
>> +               return -EINVAL;
>> +
>> +       if (chip->clk)
>> +               ret = clk_enable(chip->clk);
>> +
>> +       return ret
> 
> Also, returning uninitialized values when chip->clk is not set.
> 
> You can probably just not register these callbacks for the
> !chip->clk case.
> 

Sorry. Will correct it.
