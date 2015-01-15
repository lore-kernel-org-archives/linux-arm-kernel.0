From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 18:02:37 +0100
Subject: [PATCH v3 7/8] clocksource: atmel-st: use syscon/regmap
In-Reply-To: <54B7ED85.2090700@linaro.org>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-8-git-send-email-alexandre.belloni@free-electrons.com>
 <54B7ED85.2090700@linaro.org>
Message-ID: <20150115170237.GV3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2015 at 17:40:37 +0100, Daniel Lezcano wrote :
> >  /*
> >@@ -234,13 +201,21 @@ err:
> >   */
> >  static void __init atmel_st_timer_init(struct device_node *node)
> >  {
> >-	/* For device tree enabled device: initialize here */
> >-	of_at91rm9200_st_init();
> >+	unsigned int val;
> >+
> >+	regmap_st = syscon_node_to_regmap(node);
> >+	if (IS_ERR(regmap_st))
> >+		panic(pr_fmt("Unable to get regmap\n"));
> 
> Is it possible to get ride of those panics ? IIRC, we discussed to not panic
> when a timer was not initialized in case there is a definition for another
> one.
> 

Ok, I'll remove those.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
