From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 10:55:29 -0700
Subject: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com>
 <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
Message-ID: <152122292977.70929.17084619305591596735@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bartosz Golaszewski (2018-02-28 04:38:38)
> 2018-02-19 21:21 GMT+01:00 David Lechner <david@lechnology.com>:
> 
> I believe there to be two issues: one is with v7 - we need to increase
> the clock reference count in davinci_psc_genpd_attach_dev().
> 
> Second is the error path in the clock framework - we should remove the
> destroyed clk_core from the debug list, which is not being done now.
> 
> Why we even need to track the refcount of clk_core is a mistery for me
> though. Stephen, Mike?
> 

Which part of the code are we talking about? I see that
__clk_core_init() calls clk_debug_register() when ret == 0 and that
looks fine. I do wonder why clk_debug_register() even returns a value
though because we ignore it.
