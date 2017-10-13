From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 13 Oct 2017 14:27:33 -0500
Subject: [PATCH 3/3] arm64: cpuinfo: display product info in /proc/cpuinfo
In-Reply-To: <20170926222324.17409-4-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-4-ahs3@redhat.com>
Message-ID: <CAOZdJXWok=kHsLQLqf9sWiPibnhjnJptAteWoOA57ddEacniRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 5:23 PM, Al Stone <ahs3@redhat.com> wrote:
> +               if (IS_ENABLED(CONFIG_DMI)) {
> +                       seq_puts(m, "product name\t: ");
> +
> +                       if (!dmi_product_info)
> +                               get_dmi_product_info();
> +                       if (dmi_product_info)
> +                               seq_printf(m, "%s", dmi_product_info);

This line prints out like this:

product name    : QUALCOMM BASEBOARD ASSEMBLY, AMBERWIN
 20-P7989-H1S   , ARM 8.0 (r0p0) CPU @ 2.500GHz

Is this a bug in our DMI table?  'dmidecode' reports this:

Handle 0x0004, DMI type 2, 17 bytes
Base Board Information
        Manufacturer: QUALCOMM
        Product Name: BASEBOARD ASSEMBLY, AMBERWIN..
        Version: 20-P7989-H1S

I'm guessing that the actual string has a CR/LF at the end of "AMBERWIN"

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
