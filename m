From: alexander.levin@verizon.com (Levin, Alexander)
Date: Mon, 1 Aug 2016 11:57:58 -0400
Subject: [PATCH] net: thunderx: correct bound check in nic_config_loopback
In-Reply-To: <CA+sq2Cc-MTtoncAcL6MS-YVdeVVK=aqEmZakzkX6_CwsXvpRCQ@mail.gmail.com>
References: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
 <CA+sq2Cc-MTtoncAcL6MS-YVdeVVK=aqEmZakzkX6_CwsXvpRCQ@mail.gmail.com>
Message-ID: <6b86fd8a-e97a-8b71-1786-50aa9e667873@verizon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2016 12:41 PM, Sunil Kovvuri wrote:
> Thanks for finding.
> A much better fix would be,
> 
> -       if (lbk->vf_id > MAX_LMAC)
> +       if (lbk->vf_id >= nic->num_vf_en)
>                 return -1;
> 
> where 'num_vf_en' reflects the exact number of physical interfaces or
> LMACs on the system.

Right. I see quite a few more places that compare to MAX_LMAC vs
num_vf_en. What was the reasoning behind it then?


Thanks,
Sasha
