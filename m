From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 14:49:43 +0100
Subject: AB8500 Regulators
Message-ID: <501690F7.2010904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I've taken some time to review the way we currently initialise the 
AB8500 regulators. I don't know if you recall, but in platform code we 
have a struct full of initial values, which sets up lots of bespoke 
options. These options require lots of non-standard register writes in 
order to configure the regulators in the way which best suits 
ST-Ericsson's needs.

I wrote a patch which pulled each of these initial values into Device 
Tree, but you NACK:ed it believing that most of the options could be 
dealt with using the API. There is currently no API to set up 
ST-Ericsson's configuration. So what's the best thing to do? How do all 
of the other regulator drivers deal with non-standard configuration? Or 
is it unheard of to use non-standard start-up values?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
