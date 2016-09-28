From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 28 Sep 2016 16:41:57 -0700
Subject: [PATCH v19 05/12] fpga-mgr: add fpga image information struct
In-Reply-To: <20160928182200.15800-6-atull@opensource.altera.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
 <20160928182200.15800-6-atull@opensource.altera.com>
Message-ID: <CAAtXAHcdSsVUE4hQ6isCp7_35ZKb60EAKAgtGwBR41apwPpe=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

generally ok with the change.

On Wed, Sep 28, 2016 at 11:21 AM, Alan Tull <atull@opensource.altera.com> wrote:

> -int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
> -                     size_t count)
> +int fpga_mgr_buf_load(struct fpga_manager *mgr, struct fpga_image_info *info,
> +                     const char *buf, size_t count)

Doesn't this break the both socfpga and zynq if [6/12] and [7/12] are
not part of this commit?
i.e shouldn't 5,6 and 7 be a single commit?

Cheers,
Moritz
