From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 26 Sep 2013 11:30:23 +0200
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <20130924155925.GA2995@katana>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
 <5240AD6E.4090905@wwwdotorg.org> <5241B1FA.6020500@st.com>
 <20130924155925.GA2995@katana>
Message-ID: <5243FEAF.4090506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/24/2013 05:59 PM, Wolfram Sang wrote:
>> "glitch" is is used to tune the I2C timing requirements, and has a
>> nanosecond granularity.
>> These values are added to default timing values.
>> I'm not 100% sure, but it looks like the "samsung,i2c-sda-delay" in the
>> i2c-s3c2410 driver.
> For that, we have the generic "i2c-sda-hold-time-ns" property. The s3c
> driver hasn't been converted to use it, sadly.
>
Ok, thank you for pointing this out.
After some checks, this property doesn't match with what is done in this 
driver.

In the v2 series I am sending, I removed the I2C timing tuning as it 
works on all
the boards I have tested with.
I will only keep the anti-glitch filtering, using private properties as 
I didn't find any generic
ones that could fit.

Regards,
Maxime
