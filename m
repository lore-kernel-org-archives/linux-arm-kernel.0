From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Mar 2015 21:52:53 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150319160208.GF7657@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana>
Message-ID: <550B3725.10209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.03.2015 17:02, Wolfram Sang wrote:
>> Perhaps better would be to have a mux-specific function to iterate over a
>> mux's child nodes and instantiate buses for those. That function would check
>> whether each bus node was disabled or not. That'd isolate the special case
>> into the place where it was relevant.
>
> ... so I wonder what you think about putting the
> of_device_is_available() check into i2c_add_mux_adapter() once the
> reg-property and chan_id have been matched?
>

Ok, I see what you mean. I had a look at the place in question and
wonder what to return from i2c_add_mux_adapter() in the disabled
case so that i2c-mux-pinctrl is still happy with the returned value.

I guess what you want to have is that i2c_add_adapter() is not called
for the disabled case, right?

Is the i2c_adapter struct prepared in i2c_mux_add_adapter() still valid
if i2c_add_adapter() is not called?

Sorry, I am not too deep into i2c subsystem, I just reworked i2c-mux-
pinctrl to make it work on Dove. If you are fine with giving me some
guidance how you prefer to have it done, I can try to free some spare
time. Unfortunately there is already little of it, so please don't
expect a quick tested patch.

Sebastian
