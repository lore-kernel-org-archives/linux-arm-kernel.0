From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 15 Feb 2017 16:26:41 +0100
Subject: [PATCH v9 2/3] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <94f1d92f502b64669467c467038c3aa766b312ad.1485295905.git.stillcompiling@gmail.com>
References: <cover.1485295905.git.stillcompiling@gmail.com>
 <94f1d92f502b64669467c467038c3aa766b312ad.1485295905.git.stillcompiling@gmail.com>
Message-ID: <20170215162641.5bc50cf3@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

On Tue, 24 Jan 2017 14:19:33 -0800
Joshua Clayton stillcompiling at gmail.com wrote:
...
>+static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
>+			    size_t count)
>+{
>+	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
>+	const char *fw_data = buf;
>+	const char *fw_data_end = fw_data + count;
>+
>+	while (fw_data < fw_data_end) {
>+		int ret;
>+		size_t stride = min(fw_data_end - fw_data, SZ_4K);
>+
>+		rev_buf(fw_data, stride);

Can we make rev_buf() optional here? I've tested this driver with
Stratix-V FPGA using orion_spi driver. It works without swapping
the data.

Thanks,
Anatolij
