From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 23 May 2018 14:31:30 +0200
Subject: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
In-Reply-To: <1527057423.4607.3.camel@mtkswgap22>
References: <cover.1526374087.git.sean.wang@mediatek.com>
 <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
 <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
 <1526976323.18877.47.camel@mtkswgap22> <1527057423.4607.3.camel@mtkswgap22>
Message-ID: <B82BB5F4-E197-4915-A543-C5FF9A5A41F1@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

>> 
>> [ ... ]
>> 
>>>> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
>>>> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
>>>> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
>>> 
>>> I am not 100% sure that we want to send the HCI_DEV_SETUP event also multiple times. That is a userspace change that I would need to think about. We need to check create_monitor_event() and see what the btmon trace for this looks like. Can you send me a btmon -w trace.log when this change is active.
>>> 
>>> Regards
>>> 
>>> Marcel
>>> 
>> 
>> Sure, I'll send you the trace.log with the change is active.
>> 
>> 	Sean
>> 
> 
> 
> Attached trace.log was captured when I inputted commands power on and
> then off in bluetoothctl.

the trace.log is somehow mangled. Something is not fully correct. Can you read it with btmon -r trace.log?

Regards

Marcel
