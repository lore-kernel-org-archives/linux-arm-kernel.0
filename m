From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 26 Feb 2013 14:38:47 +0800
Subject: [Suggestion] ARM:S5PV210: version merging compiling issue for
 'struct fimc_source_info'
In-Reply-To: <CAH9JG2WS5q4SR8zk5=OC32PHLZ2+ZYva7csyshG7oANacqbCuA@mail.gmail.com>
References: <511F50CF.90403@asianux.com>
 <CAH9JG2WS5q4SR8zk5=OC32PHLZ2+ZYva7csyshG7oANacqbCuA@mail.gmail.com>
Message-ID: <512C5877.7090805@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?02?16? 19:39, Kyungmin Park ??:
> Hi,
> 
> You can find it at recent patch from Arnd.
> 

  excuse me, could you please provide more information about it ?

  I have checked 2 tags:
    the next-20130225 tag in git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

      in Feb 1 2013, by Sylwester Nawrocki, Kyungmin Park, Mauro Carvalho Chehab
      git number: 56bc911ac3b94c731db3a6de20258827f1a61c20
        in include/media/s5p_fimc.h, the structure fimc_source_info is changed.
        in arch/arm/mach-s5pv210/mach-goni.c, the structure fimc_source_info is not changed.
          still use .bus_type (not use .fimc_bus_type like others).

      it seems, the relative members forgot to change it to .fimc_bus_type.

      did the patch from Arnd still not applied into next tree ?

    the v3.8-rc7 tag in git clone git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
      it seems no relative changes (change nothing).


  thanks.

  :-)

gchen.


> Thank you,
> Kyungmin Park
> 
> On Saturday, February 16, 2013, Chen Gang wrote:
> 
>     Hello Kukjin Kim:
> 
>     ? it is a compiling issue, please help check when you have time.
> 
>     thanks.
> 
>     gchen.
> 
>     in arch/arm/mach-s5pv210/mach-goni.c:848:
>     ? error: unknown field 'bus_type' specified in initializer
> 
>     843 static struct fimc_source_info goni_camera_sensors[] = {
>     844 ? ? ? ? {
>     845 ? ? ? ? ? ? ? ? .mux_id ? ? ? ? = 0,
>     846 ? ? ? ? ? ? ? ? .flags ? ? ? ? ?= V4L2_MBUS_PCLK_SAMPLE_FALLING |
>     847 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? V4L2_MBUS_VSYNC_ACTIVE_LOW,
>     848 ? ? ? ? ? ? ? ? .bus_type ? ? ? = FIMC_BUS_TYPE_ITU_601,
>     849 ? ? ? ? ? ? ? ? .board_info ? ? = &noon010pc30_board_info,
>     850 ? ? ? ? ? ? ? ? .i2c_bus_num ? ?= 0,
>     851 ? ? ? ? ? ? ? ? .clk_frequency ?= 16000000UL,
>     852 ? ? ? ? },
>     853 };
> 
> 
>     in include/media/s5p_fimc.h:50
> 
>     ?37 /**
>     ?38 ?* struct fimc_source_info - video source description required
>     for the host
>     ?39 ?* ? ? ? ? ? ? ? ? ? ? ? ? ? interface configuration
>     ?40 ?*
>     ?41 ?* @board_info: pointer to I2C subdevice's board info
>     ?42 ?* @clk_frequency: frequency of the clock the host interface
>     provides to sensor
>     ?43 ?* @fimc_bus_type: FIMC camera input type
>     ?44 ?* @sensor_bus_type: image sensor bus type, MIPI, ITU-R BT.601 etc.
>     ?45 ?* @flags: the parallel sensor bus flags defining signals
>     polarity (V4L2_MBUS_*)
>     ?46 ?* @i2c_bus_num: i2c control bus id the sensor is attached to
>     ?47 ?* @mux_id: FIMC camera interface multiplexer index (separate
>     for MIPI and ITU)
>     ?48 ?* @clk_id: index of the SoC peripheral clock for sensors
>     ?49 ?*/
>     ?50 struct fimc_source_info {
>     ?51 ? ? ? ? struct i2c_board_info *board_info;
>     ?52 ? ? ? ? unsigned long clk_frequency;
>     ?53 ? ? ? ? enum fimc_bus_type fimc_bus_type;
>     ?54 ? ? ? ? enum fimc_bus_type sensor_bus_type;
>     ?55 ? ? ? ? u16 flags;
>     ?56 ? ? ? ? u16 i2c_bus_num;
>     ?57 ? ? ? ? u16 mux_id;
>     ?58 ? ? ? ? u8 clk_id;
>     ?59 };
>     ?60
> 
> 
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel at lists.infradead.org <javascript:;>
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Chen Gang

Asianux Corporation
