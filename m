From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 22 Oct 2016 15:43:04 +0300
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl-apalis: Do not rely on DDC I2C
 bus bitbang for HDMI
In-Reply-To: <20161022032559.GL30578@tiger>
References: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
 <20161022032559.GL30578@tiger>
Message-ID: <3d2b6dfd-c03c-e635-8dc1-2dc9ac454f5a@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 10/22/2016 06:25 AM, Shawn Guo wrote:
> On Mon, Sep 19, 2016 at 10:41:51AM +0530, Sanchayan Maity wrote:
>> Remove the use of DDC I2C bus bitbang to support reading of EDID
>> and rely on support from internal HDMI I2C master controller instead.
>> As a result remove the device tree property ddc-i2c-bus.
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>
> I think that the dw-hdmi i2c support [1] is a prerequisite of this
> patch.  I do not see it lands on v4.9-rc1.  Or am I missing something?
>
> Shawn
>
> [1] https://patchwork.kernel.org/patch/9296883/
>

I'm adding Philipp to Cc, since he is the last one who tested the change
and helped me to push the change to the mainline:

   https://lists.freedesktop.org/archives/dri-devel/2016-September/118569.html

The problem is that there is no official DW HDMI bridge maintainer, may be
you can review the change, and if you find it satisfactory push it through
ARM/iMX tree.

--
With best wishes,
Vladimir
