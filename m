From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 13 May 2014 23:12:05 -0700
Subject: [PATCH] input: pxa27x-keypad: bug fix of getting scan code
In-Reply-To: <1390797697-29217-1-git-send-email-chao.xie@marvell.com>
References: <1390797697-29217-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20140514061205.GA13621@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:41:37PM +0800, Chao Xie wrote:
> From: Chao Xie <chao.xie@marvell.com>
> 
> The rows of pxa27x-keypad used by each boards are not fixed.
> So in the driver, it will get the rows from DT and register
> the keymap as:
> matrix_keypad_build_keymap(keymap_data, NULL,
>                            pdata->matrix_key_rows,
>                            pdata->matrix_key_cols,
>                            keypad->keycodes, input_dev);
> 
> But the scan code is gotten as
> MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
> It is not correct. Fix it as
> MATRIX_SCAN_CODE(row, col, keypad->row_shift);
> 
> row_shift is calculated from pdata->matrix_key_rows.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Applied with minor edits, thank you.

-- 
Dmitry
