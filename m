From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 22 Mar 2015 14:03:56 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150321210028.GA1078@katana>
References: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana> <550B3725.10209@gmail.com>
 <20150320101925.GC2071@katana> <20150321210028.GA1078@katana>
Message-ID: <550EBDBC.9000903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.03.2015 22:00, Wolfram Sang wrote:
>>> I guess what you want to have is that i2c_add_adapter() is not called
>>> for the disabled case, right?
>>
>> I think that makes sense.
>
> But maybe we should just start simple and keep calling i2c_add_adapter()
> for the disabled case. We will just skip probing devices on the bus.
> Would that help the issue you were originally trying to solve?

It is not about probing devices on the mux sub-busses, I'd expect no
devices on the optional sub-busses in DT on boards where those pins
are not used as i2c.

The idea was to hide those busses completely in particular from
userspace on boards where they'll never be available.

If modifying i2c-mux-pinctrl to respect the sub-bus status property is
such a big issue, I'd rather leave the driver as is and expose all
sub-busses to userspace.

Sebastian
