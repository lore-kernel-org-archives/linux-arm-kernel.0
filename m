From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 10:39:54 +0530
Subject: [PATCH 04/11] arm64: dts: Initial DTS files for Broadcom Stingray
 SOC
In-Reply-To: <38356358-cfd1-9a29-2b53-80ed495573c6@gmail.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
 <1494071686-19098-5-git-send-email-anup.patel@broadcom.com>
 <38356358-cfd1-9a29-2b53-80ed495573c6@gmail.com>
Message-ID: <CAALAos_O_dpN8o0C4cUOGmP+UfRSHWep2P-j0ueMP3o7hZcgmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 5:00 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Le 05/06/17 ? 04:54, Anup Patel a ?crit :
>> The Broadcom Stingray SoC is a new member in Broadcom iProc
>> SoC family.
>>
>> This patch adds initial DTS files for Broadcom Stingray SoC
>> and two of its reference boards (bcm958742k and bcm958742t).
>>
>> We have lot of reference boards and large number of devices
>> in Broadcom Stingray SoC so eventually we will have quite
>> a few DTS files for Stingray. To tackle, we have added a
>> separate directory for Stingray DTS files.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> ---
>
>> +
>> +     scr {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0 0 0 0xffffffff>;
>
> Sorry for missing that during the internal review, the ranges property
> here should include the 6300_0000 offset such that everything else under
> the "scr" node is relative to that base address. This makes it a lot
> easier to understand the different physical addresses involved and the
> bus topology.

Sure, I will do this.

Regards,
Anup
