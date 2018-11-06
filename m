From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 6 Nov 2018 14:44:52 -0600
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <20181106183609.207702-2-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
Message-ID: <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> We have a handful of clk drivers that have a collection of slightly
> variant device support keyed off of the compatible string. In each of
> these drivers, we demux the variant and then call the "real" probe
> function based on whatever is stored in the match data for that
> compatible string. Let's generalize this function so that it can be
> re-used as the platform_driver probe function directly.

This looks really hacky to me. It sounds kind of general, but really
only works if we have match data that's a single function and we lose
any type checking on the function. What about things other than
platform devices?

Rob
