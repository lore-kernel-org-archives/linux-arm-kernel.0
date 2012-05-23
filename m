From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Wed, 23 May 2012 11:38:56 +0530
Subject: [PATCH v3 2/2] regulator: Add support for MAX77686.
In-Reply-To: <CAKew6eW2eGrBnzSGsr3N_dXSixXv-bkBo7xkbC-o9DNnwBhcuw@mail.gmail.com>
References: <y@samsung.com> <4fbb2ada.63de440a.589d.78e2@mx.google.com>
 <4FBC3FF0.5080408@samsung.com>
 <CAKew6eW2eGrBnzSGsr3N_dXSixXv-bkBo7xkbC-o9DNnwBhcuw@mail.gmail.com>
Message-ID: <CAKew6eVWtj_20zKnEVGSugqWY+JCQsE3LmDvVG78QNd1VLtf=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 9:46 AM, Yadwinder Singh Brar
<yadi.brar01@gmail.com> wrote:
> (adding Kyungmin Park and Samuel Ortiz)
>
> Hi,
>
> Yes, It happened unintentionally. I didn't know about your patch
> before submitting
> the initial version of my patches. I agree with you, I will review
> your patches and
> will try to incorporate extra features from your patches.
>

Now I have seen your patches for mfd and regulator drivers.
Apparently, it seems that mostly we same features in our patches.
Their is no extra feature to be incorporated form your patches.
Rather I found device tree support is additional in our patches
and mainly their are some differences related to DVS_GPIO and
opmode stuff in our patches:
1- Since we are not implementing and using DVS feature
through GPIOs, so all(incomplete) stuff related to dvs_gpio
is not required currently in our mfd driver presently.
2- Since presently, we are not implementing suspend_enable/disable
callbacks in regulator driver, So we don't need opmode related
stuff now because I think regulators should come up in normal mode
only through .enable callback function.

> On Wed, May 23, 2012 at 7:10 AM, ?<jonghwa3.lee@samsung.com> wrote:
>> Hi, Yadwinder,
>> As you know, both of us, recently, had competition for one driver
>> whether you intend or not. And now, i think it is time to stop this and
>> to find appropriate goal. From now on, i won't update this driver no
>> more. I recommend you to review my patch and apply feature that you can
>> apply. And also check comments that i wrote below.
>>

Thanks,
Yadwinder.
