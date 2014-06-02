From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  2 Jun 2014 14:41:00 +0100
Subject: [PATCH 0/3] i2c: Relax requirement for I2C Device ID tables
Message-ID: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

After this patch-set, it should become possible to start stripping out
those unnecessary I2C Device ID tables that are currently lurking around,
mostly redundantly.  Firstly, we create a look-up function whose job it
is to match I2C device name to a Device Tree node.  Then we add some
extra protection in i2c_match_id(), so that we can call the function with
a NULL parameter. This in turn aids to the elegance of the final change
which relaxes the requirement of a populated .id_table.

Kind regards,
Lee
