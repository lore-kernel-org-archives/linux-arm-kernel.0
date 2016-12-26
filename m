From: Satha.Rao@cavium.com (Koteshwar Rao, Satha)
Date: Mon, 26 Dec 2016 14:16:04 +0000
Subject: [RFC PATCH 5/7] Multiple VF's grouped together under single
 physical port called PF group PF Group maintainance API's
In-Reply-To: <CA+sq2Cf=3-WUaT+iNefYswgGf2ejW6EQp1igcMWELU=-xUnnNA@mail.gmail.com>
References: <1482310011-1862-1-git-send-email-satha.rao@caviumnetworks.com>
 <1482310011-1862-6-git-send-email-satha.rao@caviumnetworks.com>
 <CA+sq2Cf=3-WUaT+iNefYswgGf2ejW6EQp1igcMWELU=-xUnnNA@mail.gmail.com>
Message-ID: <DM5PR07MB2842A6B6A87F51FDB513B55A8D960@DM5PR07MB2842.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for suggestion. Will clean up code in next revision

Thanks,
Satha

-----Original Message-----
From: Sunil Kovvuri [mailto:sunil.kovvuri at gmail.com] 
Sent: Wednesday, December 21, 2016 4:44 AM
To: Koteshwar Rao, Satha
Cc: LKML; Goutham, Sunil; Robert Richter; David S. Miller; Daney, David; Vatsavayi, Raghu; Chickles, Derek; Romanov, Philip; Linux Netdev List; LAKML
Subject: Re: [RFC PATCH 5/7] Multiple VF's grouped together under single physical port called PF group PF Group maintainance API's

On Wed, Dec 21, 2016 at 2:16 PM, Satha Koteswara Rao <satha.rao@caviumnetworks.com> wrote:
> +struct tns_global_st {
> +       u64 magic;
> +       char     version[16];
> +       u64 reg_cnt;
> +       struct table_static_s tbl_info[TNS_MAX_TABLE]; };
> +
> +#define PF_COUNT 3
> +#define PF_1   0
> +#define PF_2   64
> +#define PF_3   96
> +#define PF_END 128

Some comments please ... what is 0, 64, 96 ??
You can read PCI_SRIOV_TOTAL_VF from PCI config space instead of defining PF_END with 128.
