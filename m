From: per.forlin@linaro.org (Per Forlin)
Date: Sun, 8 May 2011 15:12:46 +0200
Subject: [PATCH v3 02/12] mmc: mmc_test: add debugfs file to list all tests
In-Reply-To: <BANLkTim2k_hb0Bw_cYeTUv-dMzyWVPO+gA@mail.gmail.com>
References: <1304795706-27308-1-git-send-email-per.forlin@linaro.org>
	<1304795706-27308-3-git-send-email-per.forlin@linaro.org>
	<BANLkTim2k_hb0Bw_cYeTUv-dMzyWVPO+gA@mail.gmail.com>
Message-ID: <BANLkTindMsH4ozajW3E3ifBnrsS=gpOaOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2011 00:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Sat, May 7, 2011 at 10:14 PM, Per Forlin <per.forlin@linaro.org> wrote:
>> Add a debugfs file "testlist" to print all available tests
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> ?drivers/mmc/card/mmc_test.c | ? 30 ++++++++++++++++++++++++++++++
>> ?1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index abc1a63..c1c3c5a 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>
>
>> @@ -2476,6 +2502,10 @@ static int mmc_test_register_file_test(struct mmc_card *card)
>> ? ? ? ? ? ? ? ?file = debugfs_create_file("test", S_IWUSR | S_IRUGO,
>> ? ? ? ? ? ? ? ? ? ? ? ?card->debugfs_root, card, &mmc_test_fops_test);
>>
>> + ? ? ? if (card->debugfs_root)
>> + ? ? ? ? ? ? ? file = debugfs_create_file("testlist", S_IRUGO,
>> + ? ? ? ? ? ? ? ? ? ? ? card->debugfs_root, card, &mmc_test_fops_testlist);
>> +
>> ? ? ? ?if (IS_ERR_OR_NULL(file)) {
>> ? ? ? ? ? ? ? ?dev_err(&card->dev,
>> ? ? ? ? ? ? ? ? ? ? ? ?"Can't create file. Perhaps debugfs is disabled.\n");
> I think you also need to use similar error path for both files: test
> and testlist.
Thanks, I'll fix that and add this check for both.

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
Regards,
Per
