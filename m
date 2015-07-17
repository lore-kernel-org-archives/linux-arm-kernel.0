From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jul 2015 13:40:54 +0100
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150716121658.7982fdf5@gandalf.local.home>
References: <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
Message-ID: <20150717124054.GE26091@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> @@ -354,7 +330,7 @@ static int t_show(struct seq_file *m, vo
>  		seq_printf(m, "        Depth    Size   Location"
>  			   "    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> -			   max_stack_trace.nr_entries - 1);
> +			   max_stack_trace.nr_entries);

I believe you'll want the same fix in print_max_stack, given it's a
carbon copy.

Mark
