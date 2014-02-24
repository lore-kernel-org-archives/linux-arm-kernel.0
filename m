From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Feb 2014 11:43:27 +0100
Subject: [PATCH RFC v1 1/3] clk: Add function to parse an arbitrary clocks
 list property
In-Reply-To: <20140224004335.22529.74369@quantum>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
 <1392829124-25705-2-git-send-email-s.nawrocki@samsung.com>
 <20140224004335.22529.74369@quantum>
Message-ID: <530B224F.6010104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/14 01:43, Mike Turquette wrote:
[...]
>> > +/**
>> > + * of_clk_get_list_entry() - Parse and lookup a clock referenced by a device node
>> > + * @np: pointer to clock consumer node
>> > + * @list_name: name of the clock list property
>> > + * @index: index to the clock list
>> > + *
>> > + * This function parses the @list_name property and together with @index
>> > + * value indicating an entry of the list uses it to look up the struct clk
>> > + * from the registered list of clock providers.
>> > + */
>> > +struct clk *of_clk_get_list_entry(struct device_node *np,
>> > +                                 const char *list_name, int index)
>
> Bikeshed alert: how about of_clk_get_by_property or of_clk_get_by_prop?

That sounds better to me, thanks for the suggestion.
For the next iteration I'm going to use of_clk_get_by_property() .

Regards,
Sylwester
