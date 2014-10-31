From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Fri, 31 Oct 2014 22:44:11 +0530
Subject: [PATCH] VNIC: Adding support for Cavium ThunderX network
 controller
In-Reply-To: <20141030195458.2958d88a@urahara>
References: <20141030165434.GW20170@rric.localhost>
 <20141030195458.2958d88a@urahara>
Message-ID: <CA+sq2CfV-90CRvo-FCizkzoxHq-AsfOEDW2Z5pXtnNLNXCfTUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 8:24 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Thu, 30 Oct 2014 17:54:34 +0100
> Robert Richter <rric@kernel.org> wrote:
>
>> +#ifdef       VNIC_RSS_SUPPORT
>> +static int rss_config = RSS_IP_HASH_ENA | RSS_TCP_HASH_ENA | RSS_UDP_HASH_ENA;
>> +module_param(rss_config, int, S_IRUGO);
>> +MODULE_PARM_DESC(rss_config,
>> +              "RSS hash config [bits 8:0] (Bit0:L2 extended, 1:IP, 2:TCP, 3:TCP SYN, 4:UDP, 5:L4 extended, 6:ROCE 7:L3 bi-directional, 8:L4 bi-directional)");
>> +#endif
>
> This should managed  be via ethtool ETHTOOL_GRXFH rather than a module parameter.
Thanks, i will add setting hash options via ETHTOOL_SRXFH as well.
The idea here is to have a choice of hash while module load (through
module params) and if it needs to be changed runtime then
via Ethtool.

Sunil.
