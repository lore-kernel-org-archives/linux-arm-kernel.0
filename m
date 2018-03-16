From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 15:29:13 -0700
Subject: [PATCH 0/7] clk: add helper functions for managing
 clk_onecell_data
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <152123935331.242365.4716792321487612827@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-01-04 16:38:05)
> I am writing some clock drivers that use struct clk_onecell_data a few
> times, so I decided to write a helper function to allocate the memory
> since it is a two step process and can be tedious. Then I noticed that
> mediatek already had such a helper function, so I have moved that to the
> clk core and made use of it in other drivers where possible.
> 

We're actively trying to discourage driver authors from adding more
clk_onecell_data and pushing them to register clks and providers with
the clk_hw structures. So thanks for doing the consolidation work, but
no thanks. We can wait for the conversion to hw pointers instead.
