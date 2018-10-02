From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 2 Oct 2018 13:12:44 +0000
Subject: [PATCH] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
In-Reply-To: <1538482550-7698-1-git-send-email-ioana.ciornei@nxp.com>
References: <1538482550-7698-1-git-send-email-ioana.ciornei@nxp.com>
Message-ID: <868a0ddc-4b80-c866-a91e-7d6bc3af34da@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02.10.2018 15:16, Ioana Ciornei wrote:
> Both the header and the command parameters of the fsl_mc_command are
> 64-bit little-endian words. Use the appropriate type to explicitly
> specify their endianness.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   include/linux/fsl/mc.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index f27cb14..96c54bb 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -210,8 +210,8 @@ struct mc_cmd_header {
>   };
>   
>   struct fsl_mc_command {
> -	u64 header;
> -	u64 params[MC_CMD_NUM_OF_PARAMS];
> +	__le64 header;
> +	__le64 params[MC_CMD_NUM_OF_PARAMS];
>   };
>   
>   enum mc_cmd_status {
> @@ -238,11 +238,11 @@ enum mc_cmd_status {
>   /* Command completion flag */
>   #define MC_CMD_FLAG_INTR_DIS	0x01
>   
> -static inline u64 mc_encode_cmd_header(u16 cmd_id,
> -				       u32 cmd_flags,
> -				       u16 token)
> +static inline __le64 mc_encode_cmd_header(u16 cmd_id,
> +					  u32 cmd_flags,
> +					  u16 token)
>   {
> -	u64 header = 0;
> +	__le64 header = 0;
>   	struct mc_cmd_header *hdr = (struct mc_cmd_header *)&header;
>   
>   	hdr->cmd_id = cpu_to_le16(cmd_id);
> 
