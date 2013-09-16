From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 12:26:14 +0100
Subject: [PATCH 38/38] iio: magn-core: st: Provide support for the
 LSM303DLH
In-Reply-To: <5236DADD.3040205@st.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
 <5234A28D.1030409@kernel.org> <20130916073151.GB3999@lee--X1>
 <5236D03D.2030506@st.com> <20130916100809.GI3999@lee--X1>
 <5236DADD.3040205@st.com>
Message-ID: <20130916112614.GC16984@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Sep 2013, Denis CIOCCA wrote:

> Hi Lee,
> 
> > The driver mentions that the first group of sensors have a WAI of 
> > 0x3c: #define ST_MAGN_1_WAI_EXP 0x3c And when I print out the WAI read 
> > from the device: Requested device: lsm303dlh_magn - read WAI: 0x3c I 
> > guess I could have been lied to again by the board's datasheet again 
> > and the attached device isn't actually a LSM303DLH, but how can I tell 
> > for sure? 
> On LSM303DLH you have to read 0x0a 0x0b and 0x0c registers, you have to 
> find 0x48, 0x34 and 0x33. I think in the snowball there is the LSM303DLHC.

I just did that too:

  Device: lsm303dlh_magn: WAI: (0x3c)
  st_magn_common_probe():  IR: ID1 (0x48) ID2 (0x34) ID3 (0x33)

It appears the LSM303DLH does have a populated WAI register after all.

Now what? :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
