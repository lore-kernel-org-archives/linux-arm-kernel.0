From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 May 2015 12:17:44 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150507221842.GW22845@sirena.org.uk>
References: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
Message-ID: <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 03:48, Mark Brown <broonie@kernel.org> wrote:

> That makes sense to me.  Perhaps "current drawn by the device" rather
> than "current load of the device" since current is sadly overloaded :/

Thanks Mark. I have reworded it as:

- opp-microamp: Current drawn by the device in micro Amperes. It is used to set
  the most efficient regulator operating mode.

  Should only be set if opp-microvolt is set for the OPP.

  Entries for multiple regulators must be present in the same order as
  regulators are specified in device's DT node. If this property isn't required
  for few regulators, then this should be marked as zero for them. If it isn't
  required for any regulator, then this property need not be present.


Please let me know if this looks fine now.
