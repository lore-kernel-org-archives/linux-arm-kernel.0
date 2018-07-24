From: atull@kernel.org (Alan Tull)
Date: Tue, 24 Jul 2018 13:49:02 -0500
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
In-Reply-To: <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
Message-ID: <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 1:31 PM, Appana Durga Kedareswara Rao
<appanad@xilinx.com> wrote:
> Hi Moritz,
>
>         Thanks for the review...
>
> <Snip>
>> Can you please make the commit message such that you have full sentences?
>>
>> "Add support for readback of FPGA configuration data and registers" of
>> example.
>
> Sure will fix in v4.
>
>>
>> >
>> > Usage:
>> > Readback of PL configuration registers
>> >         cat /sys/kernel/debug/fpga/fpga0/image
>> > Readback of PL configuration data
>> >         echo 1 > /sys/module/zynqmp_fpga/parameters/readback_type
>>
>> The patch below is for Zynq if I'm not mistaken, not ZynqMP?
>
> Yes it is for Zynq not ZynqMP by mistake I have kept zynqmp here, thanks for pointing  will fix in v4...
>
> <Snip>
>> > +static bool readback_type;
>> > +module_param(readback_type, bool, 0644);
>> > +MODULE_PARM_DESC(readback_type,
>> > +               "readback_type 0-configuration register read "
>> > +               "1- configuration data read (default: 0)");
>>
>> Not sure a module param is the best solution here.
>
> Need to provide flexibility to the user to switch between reading of FPGA registers and configuration data.

I suggested calling the attribute 'image' because I thought it would
always be a read back of the FPGA image information.  I don't think
that a sysfs attribute's function should change. :)

> One other option is sysfs. Do you want me to implement sysfs path???
> Any other suggestions???

You could implement another sysfs attribute for reading FPGA registers
with a separate ops callback.   Please clarify what it is doing (not
all FPGAs have this function) and what that will look like when the
user reads the from the sysfs

Alan
