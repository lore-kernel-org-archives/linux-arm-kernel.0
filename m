From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Sat, 20 Feb 2016 21:38:16 +0800
Subject: [PATCH v11 20/21] KVM: ARM: Introduce per-vcpu kvm device controls
In-Reply-To: <20160208124059.GF620@cbox>
References: <1454656456-11640-1-git-send-email-zhaoshenglong@huawei.com>
 <1454656456-11640-21-git-send-email-zhaoshenglong@huawei.com>
 <20160208124059.GF620@cbox>
Message-ID: <56C86C48.2060702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/2/8 20:40, Christoffer Dall wrote:
>> +	case KVM_SET_DEVICE_ATTR: {
>> >+		if (copy_from_user(&attr, argp, sizeof(attr)))
>> >+			return -EFAULT;
>> >+		return kvm_arm_vcpu_set_attr(vcpu, &attr);
>> >+	}
>> >+	case KVM_GET_DEVICE_ATTR: {
>> >+		if (copy_from_user(&attr, argp, sizeof(attr)))
>> >+			return -EFAULT;
>> >+		return kvm_arm_vcpu_get_attr(vcpu, &attr);
>> >+	}
>> >+	case KVM_HAS_DEVICE_ATTR: {
>> >+		if (copy_from_user(&attr, argp, sizeof(attr)))
>> >+			return -EFAULT;
>> >+		return kvm_arm_vcpu_has_attr(vcpu, &attr);
>> >+	}
> do we share the ioctl number space across device, VM, and VCPU file
> descriptors?
Yeah, they're shared across device, VM, and VCPU.

Thanks,
-- 
Shannon
