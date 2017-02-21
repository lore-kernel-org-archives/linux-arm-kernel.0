From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 11:14:16 +0000
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <20170221110712.GB5021@amd>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd>
Message-ID: <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 11:07, Pavel Machek wrote:
> Hi!
> 
>> Enable support for "shallow" suspend mode, also known as "Standby" or
>> "Power-On Suspend".
>>
>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>> slightly more power than "s2idle", but less than "deep" suspend mode.
>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>> an optional API in PSCI v1.0.
> 
> If system supports "shallow" suspend, why does not PSCI implement it?
> 

Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
All it now needs is just to use existing "freeze" suspend mode in Linux.

> In the past, I was told PSCI will not turn into ACPI-like mess, and
> that we'll be able to fix PSCI and will not have to work around its
> problems in kernel :-(.

Can you be more elaborate on the mess you see on this Renesas platform.

For me, it looks like this patch is attempting to *re-implement* the
existing "suspend-to-idle" functionality. So IMO, this patch set is
creating unnecessary mess giving an illusion that PSCI specification is
broken.

-- 
Regards,
Sudeep
